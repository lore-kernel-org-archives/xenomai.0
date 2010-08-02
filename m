Message-ID: <4C562838.8050000@domain.hid>
Date: Sun, 01 Aug 2010 19:06:48 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Shared memory between a Xenomai user task and a
	standard Linux process?
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

  I understand that a RT_PIPE is the preferred way to move data between 
a rt user task and a standard Linux process, but I have a large amount 
of data to move per second and I would like to minimize the number of 
times that the data is copied.

My rt user task performs several tasks that need to be time 
deterministic. I also want to store a history of its activity in a 
standard Linux file. Adequate buffering is available so that the file 
writing and management does not need to be done in real time.

Ideally, I would like to share a block of memory (~128KB) between the rt 
user task and a standard Linux process which performs the file activities.

The documentation indicates that many API calls are available to "user 
tasks", but I assume that unless "Linux process" is explicitly mentioned 
(as in the case of "pipe") these references apply only to rt user tasks. 
Am I correct?

Is there a shared memory mechanism that works between a rt user task and 
a standard Linux process?

Is there a way to operate a RT_PIPE in a zero copy mode? That is, the rt 
user task constructs the message in the in the same buffer that is made 
accessible a standard Linux process to perform a fwrite() from it.

Also, what what exactly does the poolsize parameter of pipe_create 
module do?
I assume that it is specified in units of bytes. My message size is 16KB 
and a message will be sent about every 140 milliseconds. I expect that 
no more than 2 or 3 messages will queue up before the "standard Linux 
process" can consume them, but for safety I want to allow for 8 (128KB). 
Will a poolsize of 128KB sufice or is the pool also consumed by other 
invisible things too?

Regards,
Bob Feretich

