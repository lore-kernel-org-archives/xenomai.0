Message-ID: <4E157F1C.9060606@domain.hid>
Date: Thu, 07 Jul 2011 11:40:44 +0200
From: Kim Mathiassen <kimmat@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] 32 bits libraries for x86_64 architecture
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi

I am doing a project where I am going to use Labview for linux. 
Unfortunately Labview only have a 32-bit version and I have a 64 bit 
system. I want to use Xenomai with Labview for DAQ, and therefor I need 
32 bits libraries that Labview can call. I read a message in the 
mailing-list which where of a similar character:

https://mail.gna.org/public/xenomai-help/2008-05/msg00294.html

I have tried to compile the user-space Xenomai libraries with the m32 
option, but I only get -ENOSYS error which implies that the function is 
not implemented. Is there any plan to implement 32 bit wrappers for a 64 
bit system? Do I have to install a 32 bit kernel in order to use Xenomai 
with Labview? Does anyone have a suggestion on how to solve the problem?

I the message the linked to above, it was suggested that I could 
implement the wrappers. Does anyone know about how much work this would 
be? If it isn't a lot of work, maybe someone could point me to where in 
the code I should start looking.

I am also thinking of making a 64 bit deamon that a 32 bit library can 
communicate with. I am not sure if this will work, because I do not know 
if there are IPC (InterProcess Communication) that can handle both 32 
and 64 bit on Linux?

Best regards
Kim Mathiassen

