Resent-Message-ID: <17908.31288.37141.125796@domain.hid>
Resent-To: xenomai@xenomai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17908.20496.71389.645920@domain.hid>
In-Reply-To: <38b44d590703102107l159cda49rdf7ad7c1dc435b3@domain.hid>
References: <38b44d590703060949lfa70769na93c19abd2ff248f@domain.hid>
	<45EDAB66.9070700@domain.hid> <45EDAD18.9080701@domain.hid>
	<38b44d590703061059x1ddc72aau9ead4838a7fa6cb7@domain.hid>
	<17901.50169.379195.372477@domain.hid>
	<38b44d590703102107l159cda49rdf7ad7c1dc435b3@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] process memory not locked
Date: Sun, 11 Mar 2007 19:53:04 +0100
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

Saiful Khan wrote:
 > Sorry for late reply. Actualy what I saw that in that application one
 > fork() is there, so basically child process is trying to create the thread
 > and fails. I removed the fork() and spawned the thread from the main and
 > succeed. But the application is so large that, if i remove the fork() then I
 > need to change the entire architecture of the application, another big
 > task... Can u please tell me what is the alternative of fork()?
 > 
 > Thanks and regards
 > Saiful

To quote mlockall manual page: "Memory  locks  are not inherited by a
child created via fork(2) and are automatically removed (unlocked)
during an execve(2) or when  the  process terminates."

So, a forked child has to call mlockall to lock its memory.

Beware, however, that calling fork in a real-time application raises
some issues which have been solved recently: only trunk and latest
branch v2.3.x contain the fixes needed to safely call fork in a
real-time application.

-- 


					    Gilles Chanteperdrix.

