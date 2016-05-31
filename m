MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 31 May 2016 15:15:31 +0200
From: mfinkbei <mfinkbei@stud.hs-heilbronn.de>
In-Reply-To: <20160525101146.GH13609@hermes.click-hack.org>
References: <0abe0634dbf999057bf8529e0cc0ecd8@stud.hs-heilbronn.de>
 <20160523075954.GJ13609@hermes.click-hack.org>
 <674a5761ce5e9da1774b90b499a2e3d6@stud.hs-heilbronn.de>
 <20160524135324.GA11602@hermes.click-hack.org>
 <48747eda7ad827e2f69dd3d159a606bc@stud.hs-heilbronn.de>
 <b19757cdceb6cde95fb69b49a99f1361@stud.hs-heilbronn.de>
 <0ffacf8b2a8fe70df9e590c2964e3639@stud.hs-heilbronn.de>
 <20160524180256.GM13609@hermes.click-hack.org>
 <82d75d19468fc00b0b447ba3fc5a9bcd@stud.hs-heilbronn.de>
 <20160525101146.GH13609@hermes.click-hack.org>
Message-ID: <2996ea588d38fe1ce3e14ea9371bfeb3@stud.hs-heilbronn.de>
Subject: Re: [Xenomai] Xenomai on Udoo Neo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am 2016-05-25 12:11, schrieb Gilles Chanteperdrix:
> 
> Basically what you showed here does not show what particular dts
> your device uses, since all the dtbs are copied. So, no, you do not
> know yet if the dtb your device actually loads contains the
> declaration of the global timer.

You were right.
With the command cat /proc/device-tree/compatible I have found out that 
the file imx6sx is used in the device tree instead of imx6qdl.
After I declared the timer in the imx6sx.dtsi file Xenomai was running.
Thank you for your help, Gilles.


