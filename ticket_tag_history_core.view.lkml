include: "//@{CONFIG_PROJECT_NAME}/ticket_tag_history.view.lkml"

view: ticket_tag_history {
  extends: [ticket_tag_history_config]
}

view: ticket_tag_history_core {
  sql_table_name: @{SCHEMA_NAME}.ticket_tag_history ;;

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }

  dimension: tagged {
    type: yesno
    sql: ${TABLE}.tagged ;;
  }

  dimension: ticket_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.ticket_id ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: DATETIME(${TABLE}.created_at) ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [user.id, user.custom_lead_or_contact_first_name, user.name, ticket.id]
  }
}
