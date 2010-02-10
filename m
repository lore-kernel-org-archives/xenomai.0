Message-ID: <4B72F360.4050209@domain.hid>
Date: Wed, 10 Feb 2010 10:56:48 -0700
From: Michael Buksas <mwbuksas@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] S_memLib_NOT_ENOUGH_MEMORY error in porting VxWorks
	application.
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

I'm porting a VxWorks application to Xenomai/SOLO and getting 
S_memLib_NOT_ENOUGH_MEMORY errors from taskSpawn.

I'm currently running on a desktop Linux system, so I doubt physical 
memory is an issue. Rather, I think it's the allocation of memory for 
tasks, and my crushing ignorance about how to do the same.

For example, does this occur when the memory needs of the task exceed 
the stack size argument to taskSpawn? Increasing this value does not 
appear to help.

Can anyone suggest how to further diagnose the memory problem?

And to address the broader question, where should a raw beginner at 
embedded programming go for documentation on Xenomai/SOLO and guidance 
for the porting process?

Thanks in advance,
Mike


