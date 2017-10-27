References: <local-8a4e01bb-e3b0@nylas-mail.nylas.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1ebd2c2c-e3dd-4023-834b-1a0e4e004a08@xenomai.org>
Date: Fri, 27 Oct 2017 12:04:31 +0200
MIME-Version: 1.0
In-Reply-To: <local-8a4e01bb-e3b0@nylas-mail.nylas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0.5 - Segmentation fault in
 xnsynch_sleep_on(); 
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Piotr Piorkowski <qba100@gmail.com>, "xenomai xenomai.org" <xenomai@xenomai.org>

On 10/26/2017 08:48 PM, Piotr Piorkowski wrote:
>    Hello
> 
>    I'm running rtdm kernel module using the xenomai 3.0.5 and Linux 4.1.21
>    on RPi 3
>    I have problem with spi-bcm2835 rtdm driver (from official
>    xenomai kernel source).
>    When I am using write function, I get segmentation fault.
>    Problem is on xnsynch_sleep_on() function:  xnthread_current() retrun
>    NULL.
>    Best Regards
>    Piotr PiA^3rkowski
> 
>    [05cd4d4c8919f560c95bcb85a4ccc92404cecc76ba3dced93a3fc9c290ffda0f]


If this breaks in kernel space, you should have a stack backtrace dumped
to the kernel log. Please provide it.

-- 
Philippe.

