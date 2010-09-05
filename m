Message-ID: <4C841BEF.50708@domain.hid>
Date: Sun, 05 Sep 2010 15:38:39 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Native rt_event_bind() question.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

  I am confused about the operation of the Native rt_event_bind() 
function and I have not found any example of its use.

The documentation states...
int rt_event_bind (RT_EVENT * event, const char * name, RTIME timeout)
Parameters:
...
event The address of an event flag group descriptor retrieved by the 
operation. Contents of
this memory is undefined upon failure.
...

Is the user-space task supposed to provide memory for the RT_EVENT, ...
example:
RT_EVENT event_structure;
...
rt_event_bind (&event_structure,...)

Or, does the user-space program just provide a pointer variable to 
retain the event structure provided to it by the function?
example:
RT_EVENT *event_pointer;
...
rt_event_bind (event_pointer,...)

Neither seems to work correctly, the former only allocates a word of memory.
printf("sizeof(event_structure)=%d", sizeof(event_structure) );
Prints 4. This seems too small.

The latter fails with an error code -14 (EFAULT).

Regards,
Bob Feretich


