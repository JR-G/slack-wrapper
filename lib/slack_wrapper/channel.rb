require 'slack-ruby-client'
require 'dotenv/load'

module SlackWrapper
  class Channel
    attr_reader :identifier

    def initialize(identifier:, token: nil)
      @identifier = identifier
      @token = token
    end

    def post_a_message!(text:)
      client.chat_postMessage(
        channel: identifier,
        text: text
      )
    end

    def post_a_scheduled_message!(text:, time:)
      client.chat_scheduleMessage(
        channel: identifier,
        text: text,
        post_at: time
      )
    end

    def pin_a_message!(message_timestamp:)
      client.pins_add(
        channel: identifier,
        timestamp: message_timestamp
      )
    end

    def topic
      client.conversations_info(
        channel: identifier
      ).dig(:channel, :topic, :value)
    end

    def members
      client.conversations_members(
        channel: identifier
      ).members
    end

    def invite_users!(users:)
      client.conversations_invite(
        channel: identifier,
        users: users.join(',')
      )
    end

    def invite_user!(user:)
      client.conversations_invite(
        channel: identifier,
        users: user
      )
    end

    def create_topic!(summary:)
      client.conversations_setTopic(
        channel: identifier,
        topic: summary
      )
    end

    def client
      @client ||= self.class.client
    end

    class << self
      def client
        Slack::Web::Client.new(token: @token || ENV['SLACK_TOKEN'])
      end

      def create!(name:, is_private: false)
        client.conversations_create(
          name: name,
          is_private: is_private
        )
      end
    end
  end
end
