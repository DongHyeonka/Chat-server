package com.synapse.chat_service.domain.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.synapse.chat_service.domain.entity.Message;
import com.synapse.chat_service_api.dto.response.MessageResponse;

public interface MessageRepository extends JpaRepository<Message, Long> {
    @Query("SELECT new com.synapse.chat_service_api.dto.response.MessageResponse$History(m.id, m.conversation.id, m.senderType, m.content, m.createdDate, m.updatedDate) "
            +
            "FROM Message m " +
            "WHERE m.conversation.id = :conversationId " +
            "AND (:cursorId IS NULL OR m.id < :cursorId) " +
            "ORDER BY m.id DESC")
    List<MessageResponse.History> findByConversationIdWithCursorDesc(
        @Param("conversationId") UUID conversationId, 
        @Param("cursorId") Long cursorId,
        Pageable pageable
    );
}
