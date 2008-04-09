From: "Robert McCullough" <rob@domain.hid>
Date: Wed, 9 Apr 2008 15:13:41 -0400
Message-ID: <000701c89a75$d349f630$9601a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] mlockall questions
Reply-To: rob@domain.hid
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

Hi,

I am converting part of a C++ application to real-time.

I noticed that all the Xenomai examples call
mlockall(MCL_CURRENT|MCL_FUTURE) at the beginning of main before creating
any real-time threads.
Is calling mlockall a requirement when using Xenomai?

I have added a couple of Xenomai tasks to my C++ app.
A) Without calling mlockall my application seems to run fine but I noticed
in /proc/xenomai/stat that a few page faults occurred.
B) When calling mlockall at the beginning of my main() I do not see any page
faults but some of the C++ threads do not start.

Why would mlockall cause some threads not to start?
How would I fix this?

Best regards, 
Robert McCullough




