Message-ID: <49621EF0.9050604@domain.hid>
Date: Mon, 05 Jan 2009 14:53:36 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1231163752.49621168d278c@domain.hid>
In-Reply-To: <1231163752.49621168d278c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_printf and file writing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: nourry@domain.hid
Cc: xenomai@xenomai.org

nourry@domain.hid wrote:
> Hi all,
> 
> maybe another silly question but where is written string passed to rt_printf ?
> My program compiled fine but nothing appears on the screen, the issue is that
> i'm doing data acquisition and i need to check during progression values i get
> (anyway i've been asked to print these values on the screen).
> 
> Another thing, in order to keep these data even if the computer may come to
> crash, we would appreciate to save them in a file, is there a way to do so in
> realtime ?

Printing on the screen or to a file uses Linux drivers, so is not a
real-time operation, at least up to now with Xenomai. What you can do is
get real-time tasks to use a buffering IPC of some sort to let a non
real-time task do the actual writing to file or to the screen.

This is what rt_printf does. So, maybe you do not see anything because
your real-time task is running all the time and does not let linux run?

-- 
                                                 Gilles.

