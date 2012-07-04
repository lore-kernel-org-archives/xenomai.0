Message-ID: <4FF4335D.8020403@xenomai.org>
Date: Wed, 04 Jul 2012 14:13:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <e5fb2f9d1989e086.4ff44dd7@hs-harz.de>
In-Reply-To: <e5fb2f9d1989e086.4ff44dd7@hs-harz.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtai emulator missing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Wisse <mwisse@hs-harz.de>
Cc: xenomai@xenomai.org

On 07/04/2012 02:06 PM, Michael Wisse wrote:
> Hello,
>
> I switched from xenomai 2.5.1 to 2.6.0.  We use software originally written for rtai with the rtai emulator from 2.5.1.
>
> Now in xenomai 2.6.0 there seems to be no rtai-emulator and no rtai skin anymore. After patching the kernel 2.6.38.8  with xenomai 2.6.0 there is no kernel configuration option for rtai-emulator and I am unable to build my kernel modules, because the rtai headers are missing in xenomai.
>
> In which version the rtai skin was removed from xenomai and why?

This skin was removed in 2.6.0, because only the kernel-side API was 
emulated, we had no incentive for maintaining that code due to the lack 
of users sending feedback, and nobody went for contributing LXRT 
emulation after all these years. People seem to prefer porting to the 
native Xenomai API instead. So I have decided to remove it entirely, to 
stop bit roting.

>
> Do I have to port the rtai-code to xenomai-native-api if I want to use xenomai 2.6.0?
>

Yes.

> regards
> Michael
>
>
>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.



