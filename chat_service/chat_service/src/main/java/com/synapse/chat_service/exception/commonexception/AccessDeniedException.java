package com.synapse.chat_service.exception.commonexception;

import com.synapse.chat_service.exception.domain.ExceptionType;

public class AccessDeniedException extends BusinessException {
    public AccessDeniedException(ExceptionType exceptionType) {
        super(exceptionType);
    }
}
