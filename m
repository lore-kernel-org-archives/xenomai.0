MIME-Version: 1.0
References: <SN6PR08MB5661EE942B37DBEF57E8272F939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB5661EE942B37DBEF57E8272F939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun, 28 Feb 2021 08:08:08 -0500
Message-ID: <CALLqZ8TGuwZ5Z0djHjGS7RkR7H=c8oWiGPwsmgWLhGhmCmAzaw@mail.gmail.com>
Subject: Re: GPIO interrupt reading timeout
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriel Dinse <gabriel_dinse@hotmail.com>
Cc: xenomai@xenomai.org

On Sun, Feb 28, 2021 at 7:18 AM Gabriel Dinse via Xenomai <
xenomai@xenomai.org> wrote:

> Hello,
>
> I currently have a loop rt_task for reading interrupts on a GPIO pin of
> my raspberry pi.
>
> I'm using:
> ret = read(pin, &value, sizeof(value));
>
> but I don't want it to block forever, because my task should exit when
> there are not more interrupts to read. Can I use "select" for
> introducing a reading timeout on my loop and yet being "real-time"?
>
> Thank you,
> Gabriel Dinse


>
If you are using the posix skin ( which I believe you are) then yes, using
select will translate into using the RT version of select, and you can use
a timeout.

Thanks

Greg

>
>
