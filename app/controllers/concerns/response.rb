module Response
  def json_response(messages, is_success, date, status)
    render json: {
        messages: messages,
        is_success: is_success,
        date: date
    }, status: status
  end
end