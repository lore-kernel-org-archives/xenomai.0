Sender: karim@domain.hid
Message-ID: <3ED26BCB.FDD29D2A@opersys.com>
Date: Mon, 26 May 2003 15:32:27 -0400
From: Karim Yaghmour <karim@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] I have one question
References: <001b01c3209e$9cb205a0$4d4c4150@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Reply-To: karim@domain.hid
List-Id: <adeos-main.nongnu.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Hidic Anel <patlidzan@domain.hid>
Cc: adeos-main@gna.org


Hidic Anel wrote:
> If we have 2 OSs running side by side, how is implemented process scheduling
> between OSs. I mean if we have 10 processes per OS, how can we switch
> between them, so that we have impression of parallel running of 2 OSs

Adeos doesn't implement OS scheduling, though other nanokernels do (see
exokernel paper for example.) One thing you can do with Adeos is build
the entire systems so that each OS only takes a certain portion of the
CPU. For example, you can modify the OS scheduler so that all active
tasks cannot take more that x% of the CPU time. You could also extend
Adeos to implement an OS scheduler a-la exokernel.

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================


