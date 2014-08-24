require "power_assert"

module PowerAssert
  class PryContext < Context

    # args line means assertion_proc_string
    def initialize(assertion_proc, assertion_method, line)
      @line = line
      methods = nil
      refs = nil
      method_ids = nil
      return_values = []
      @base_caller_length = -1
      @assertion_proc = assertion_proc
      @assertion_method_name = assertion_method.to_s
      @message_proc = -> {
        @assertion_message ||=
          @base_caller_length > 0 ? assertion_message(@line || '',
                                                      methods || [],
                                                      return_values,
                                                      refs || [],
                                                      assertion_proc.binding).freeze :
                                    nil
      }
      @proc_local_variables = assertion_proc.binding.eval('local_variables').map(&:to_s)
      @trace = TracePoint.new(:return, :c_return) do |tp|
        next if method_ids and ! method_ids.include?(tp.method_id)
        locs = tp.binding.eval('caller_locations')
        if locs.length - @base_caller_length == TARGET_CALLER_DIFF[tp.event]
          idx = TARGET_CALLER_INDEX[tp.event]
          idents = extract_idents(Ripper.sexp(@line))
          methods, refs = idents.partition {|i| i.type == :method }
          method_ids = methods.map(&:name).map(&:to_sym).uniq
          return_values << Value[tp.method_id.to_s, tp.return_value, nil]
        end
      end
    end
  end
  private_constant :PryContext

  def start_with_string(assertion_proc, line, assertion_method: nil)
    yield PryContext.new(assertion_proc, assertion_method, line)
  end
  module_function :start_with_string
end
