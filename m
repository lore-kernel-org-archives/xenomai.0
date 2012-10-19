MIME-Version: 1.0
In-Reply-To: <2831_1350286976_507BBE80_2831_9511_1_4008F9ABAF25EA469EA100EAC59FE290011C429A5EA0@THSONEA01CMS01P.one.grp>
References: <CAN0CFw1gjwCJO0oauUQX5XdyE3b1XetPYa2y2d30csOaGdjmQA@mail.gmail.com>
	<CADg0w=qa5vo_WbACjEU5zrFiWFzQETPj2Yg2LeW1WeEQsqH4xg@mail.gmail.com>
	<50790563.8000403@xenomai.org>
	<2831_1350286976_507BBE80_2831_9511_1_4008F9ABAF25EA469EA100EAC59FE290011C429A5EA0@THSONEA01CMS01P.one.grp>
Date: Fri, 19 Oct 2012 08:40:42 -0700
Message-ID: <CAN0CFw2g2EW9eabuN7g=ttm_BYMSa4sh+j1Rj1E_mq5NqnJsdA@mail.gmail.com>
From: Grant <emailgrant@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai on Gentoo?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> So time ago I needed to install Xenomai on gentoo.
>
> For that I made 2 gentoo portage ebuild : one for the xenomai library, and one for the xenomai patched kernel.
>
> I have just created a github project for that : https://github.com/iXo/iXoGentooOverlay
>
> Maybe this can help you.
>
>
> It is a little outdated now, but updating it should not be very difficult.

Thanks a lot for that!

- Grant


>> Hi Grant,
>>
>> About a year ago, I had 3-4 realtime production motor controller servers
>> running on Xenomai/Gentoo and it worked exceptionally well.  The
>> portage/ebuild system made it easy to verify Xenomai was installed as well
>> as configure and compile my application code with realtime support.
>>
>> I used the Xenomai quickstart
>> guide<http://www.xenomai.org/index.php/Xenomai_quick_build_quide>in
>> conjunction with the gentoo
>> quick system install
>> guide<http://www.gentoo.org/doc/en/gentoo-x86-quickinstall.xml>.
>>  Since you typically configure/compile/install kernels by hand in gentoo,
>> adding Xenomai wasn't much of a leap.
>
>
> Xenomai wiki is locked, but it is not because we do not want
> contributions, so, if someone wants write access to the wiki, write a
> page on installing xenomai on gentoo, upload the ebuild, we can do that.

