Date: Tue, 28 Feb 2006 09:24:02 -0800
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C029C732.259D%steve@domain.hid>
In-Reply-To: <44047C3D.40104@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

All right, all right. I surrender. *waves the white flag*

Let's just say that I saw something different from fusion/classic RTAI and
was reporting it as a possible bug incorrectly, all right?

I'll still have to send you a bill. :)

Steven

On 2/28/06 8:37 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> The global timeline the whole RTOS is working on does not stop for suspended
> threads, this is what you seem to be missing since the very beginning of this
> discussion. For instance, forcibly suspending a task (e.g. using
> rt_task_suspend) 
> while it is already undergoing a blocked state with a timeout (e.g. pending on
> some sempahore to become available, whatever) does not prevent the timeout to
> be 
> decremented tick after tick. This is called cumulative suspension states, and
> all 
> the RTOS I know of enforce that. Fortunately.


