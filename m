Message-ID: <44C9088A.20608@domain.hid>
Date: Thu, 27 Jul 2006 11:40:10 -0700
From: Nathaniel Villaume <villaume@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] doc patch: RT_TASK_INFO
References: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>
	<44C8EECE.4070209@domain.hid>
In-Reply-To: <44C8EECE.4070209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

The patches were to help you out! I thought that maybe you wouldn't want 
RT_TASK documented -- users don't really need to konw about magic number 
and flowgen, do they?  But yeah, sorry for the spamming.

As for the comment style, the C style comments don't show up using this 
inline method: /*!< */   -- that was part of the original problem.  One 
solution is to use the @typedef command. The only drawback here is the 
minor replication. For example:

/*! @typedef RT_TASK
    @brief Contains important data
  @param  magic  Magic uniquely identifies the task's wizardry ancestry
  @param  prio   task priority
*/
typedef struct {
  int magic;  // Must come first!   (comments don't HAVE to go here)
  uint prio;  // task priority
  /* etc */
} RT_TASK;

What I need to know from you:
1) Do you care about this duplication of struct member-names (harder to 
keep docs synchronized with code)?
2) Do you want RT_TASK member documentation to show up in 
doxygen-generated pages?  (this lets me know what to change)

-Nate


