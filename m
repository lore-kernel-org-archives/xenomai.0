References: <CALLqZ8QZZovg3CvE+-tpJpyvzH4NHkVpA=Kh=EX=-ZLo_ivw7w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <31d6c7d9-0f08-0201-105d-56d906467489@xenomai.org>
Date: Tue, 17 Apr 2018 09:44:50 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8QZZovg3CvE+-tpJpyvzH4NHkVpA=Kh=EX=-ZLo_ivw7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Increase RTDM_MAX_MINOR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/14/2018 04:20 AM, Greg Gallagher wrote:
> Currently in the rtdm gpio drivers if the pin numbers we are trying to
> register in rtdm space are above 1024 we will fail to register the
> pins and the driver fails to load.  This happens because we use
> RTDM_MAX_MINOR to limit the number of devices that can be registered.
> For the gpio case adding a pin with a high pin number doesn't mean
> that we have that many devices registered.  For example on the
> raspberry pi2 the gpio pins start at 1994, but only the gpio rtdm
> driver is loaded and we don't have 1994 rtdm devices registered.
>   I've tested out increasing the RTDM_MAX_MAJOR to 4096, which works
> but I'm not sure this is the best solution.  Another solution could be
> to subtract RTDM_MAX_MAJOR from the pin number if it's above
> RTDM_MAX_MAJOR but we would now have pin numbers different from that
> of the Linux gpio subsystem.
>     Any thoughts on the best approach?
> 

RTDM only allocates a namespace with alloc_chrdev_region() for covering
0..RTDM_MAX_MINOR-1 entirely, plus one entry in its own bitmap per
minor, so raising RTDM_MAX_MINOR should be fine, i.e. that would not
lead to over consume memory uselessly. Other options look complicated
and error-prone.

-- 
Philippe.

