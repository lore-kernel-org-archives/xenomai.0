Message-ID: <54DB6A71.9080002@xenomai.org>
Date: Wed, 11 Feb 2015 15:42:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CALe7ZU0uhfwq6jGHFfsO_9pcfKYrCstRDxaPi3WO-wamK0ThPA@mail.gmail.com>
In-Reply-To: <CALe7ZU0uhfwq6jGHFfsO_9pcfKYrCstRDxaPi3WO-wamK0ThPA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Power management frame work in RTDM xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>, xenomai <xenomai@xenomai.org>

On 02/11/2015 02:48 PM, JAY KOTHARI wrote:
> Hello,
>         I am using power management frame work with RTDM. If my
> process is in suspended state and am requesting irq in RTDM or open
> call from rt_dev_open then will it resume the device????
> My user api rt_dev_open is unable to find the RTDM for it. Is there
> any other approach of power management in RTDM???

There is absolutely no support for PM in Xenomai, including with RTDM.

-- 
Philippe.

