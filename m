From: Thomas Witzel <witzel.thomas@domain.hid>
Subject: Re: [Xenomai-help] Re: RTDM driver questions
Date: Sun, 21 May 2006 21:19:53 +0000
References: <050720061514.21865.445E0ED2000D33230000556922058863609C0E0301089BD2040A969B0799@domain.hid>
	<200605072202.22555.witzel.thomas@domain.hid>
	<if82j3-9ug.ln1@domain.hid>
In-Reply-To: <if82j3-9ug.ln1@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605212119.53330.witzel.thomas@domain.hid>
Reply-To: witzel.thomas@domain.hid
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

I have that now, but I'm not really sure how to synchronize the user space 
application with the driver, since the driver has of course only a limited 
buffer. Practically now I have a 512 sample buffer in the driver that I use 
as a double buffer and I copy blocks of 256 to the user on read. 
Isn't there a way to have a FIFO between driver and user application and is 
there an example somewhere, where I can see how this is done properly ?

Independently of that, if the user space application dies, how can I remove 
the driver then ?

Thank you,

Thomas


On Sunday 07 May 2006 22:21, Bernhard Walle wrote:
> Hi Thomas,
>
> Thomas Witzel <witzel.thomas@domain.hid> [2006-05-07]:
> > > Generally spoken, mmap can make sense if you have a significant amount
> > > of data to transfer, not "just" a few kbyte/s. RTDM has the elementary
> > > support for such device interfaces now, and this has already been used
> > > for a frame-grabbing driver.
> >
> > What would be the proper procedure for just a few kbytes ? I expect less
> > than 500 kB./second in my application.
>
> Simply read() / write() ?
>
>
> Regards,
>   Bernhard

