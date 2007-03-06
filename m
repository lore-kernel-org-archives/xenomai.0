MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17901.50169.379195.372477@domain.hid>
Date: Tue, 6 Mar 2007 20:41:45 +0100
Subject: Re: [Xenomai-help] process memory not locked
In-Reply-To: <38b44d590703061059x1ddc72aau9ead4838a7fa6cb7@domain.hid>
References: <38b44d590703060949lfa70769na93c19abd2ff248f@domain.hid>
	<45EDAB66.9070700@domain.hid> <45EDAD18.9080701@domain.hid>
	<38b44d590703061059x1ddc72aau9ead4838a7fa6cb7@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saiful Khan <saiful.etc@domain.hid>
Cc: xenomai@xenomai.org

Saiful Khan wrote:
 > Hello,
 > 
 > First of all thank you a lot. For the last several days I am getting lots of
 > help from you. As well as I achived some positive results also. By the way
 > my observation now is -
 > 
 > mlockall is successfull
 > pthread_attr_init() - is successfull
 > pthread_attr_setdetachstate() - successfull
 > Here I am getting the message "Xenomai - process memory not locked (missing
 > mlockall?)" and its stuck.
 > pthread_create()  - this is returning nothing not success(0) nor failure.
 > 
 > What can be the possible reason?

Maybe a bug, could you tell us what version of the Adeos patch and of
Xenomai you are using, and send a short program that exhibits this
behaviour ?

-- 


					    Gilles Chanteperdrix.

