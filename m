From: Der Herr Hofrat <der.herr@domain.hid>
Message-Id: <200403011806.i21I6hw23723@domain.hid>
Subject: Re: [Adeos-main] adeos and cpu time
In-Reply-To: <1078155663.4043598f8d3b9@domain.hid> from "nicolas2@domain.hid"
 at "Mar 1, 2004 04:41:03 pm"
Date: Mon, 1 Mar 2004 19:06:43 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: nicolas2@domain.hid
Cc: adeos-main@gna.org

> I use adeos with RTAI.
> I'd like to know if it's possible to configure Adeos to let always 5% of CPU
> time at Linux so as to allow the refresh of the screen (for example). 
>
this is not realy an ADEOS problem but a RTAI problem
fundamentally you are asking "how can I ensure priority inversion
on my system" - the simple answer is ensure that all RT-tasks
yield the CPU and don't over commit the CPU in RT-context.

If linux never gets scheduled then there are runable RT-tasks
and in such a situation the idle task may simply not run.

hofrat 

