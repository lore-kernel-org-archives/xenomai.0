Message-ID: <44047C3D.40104@domain.hid>
Date: Tue, 28 Feb 2006 17:37:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
References: <C029BA24.258F%steve@domain.hid>
In-Reply-To: <C029BA24.258F%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Steven Seeger wrote:
> If time stopped for you, would you be aware of anything?
> 

The global timeline the whole RTOS is working on does not stop for suspended 
threads, this is what you seem to be missing since the very beginning of this 
discussion. For instance, forcibly suspending a task (e.g. using rt_task_suspend) 
while it is already undergoing a blocked state with a timeout (e.g. pending on 
some sempahore to become available, whatever) does not prevent the timeout to be 
decremented tick after tick. This is called cumulative suspension states, and all 
the RTOS I know of enforce that. Fortunately.

> On 2/28/06 8:20 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:
> 
> 
>>Precisely not, it should be aware that time keeps advancing regardless of its
>>own 
>>status, suspended or not.
> 
> 
> 


-- 

Philippe.

