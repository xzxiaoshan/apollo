package com.ctrip.framework.apollo.biz.entity;

import com.google.common.base.MoreObjects;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * @author Jason Song(song_s@ctrip.com)
 */
@Entity
@Table(name = "RELEASEMESSAGE")
public class ReleaseMessage {
  @Id
  @GeneratedValue(generator = "snowflakeIdGeneratorConfig")
  @GenericGenerator(
          name = "snowflakeIdGeneratorConfig",
          strategy = "com.ctrip.framework.apollo.common.service.SnowflakeIdGeneratorConfig"
  )
  @Column(name = "Id")
  private long id;

  @Column(name = "Message", nullable = false)
  private String message;

  @Column(name = "DataChange_LastTime")
  private Date dataChangeLastModifiedTime;

  @PrePersist
  protected void prePersist() {
    if (this.dataChangeLastModifiedTime == null) {
      dataChangeLastModifiedTime = new Date();
    }
  }

  public ReleaseMessage() {
  }

  public ReleaseMessage(String message) {
    this.message = message;
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  @Override
  public String toString() {
    return MoreObjects.toStringHelper(this)
        .omitNullValues()
        .add("id", id)
        .add("message", message)
        .add("dataChangeLastModifiedTime", dataChangeLastModifiedTime)
        .toString();
  }
}
