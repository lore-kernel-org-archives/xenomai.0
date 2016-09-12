References: <b3a6f4c97449444a9f315329b4b7faf1@AM3PR48MB0130.041d.mgd.msft.net>
 <1d69d480-52da-5a17-2ca9-d9b5ce296501@mperpetuo.com>
 <8d544c56950547518f0e6aa5908ddf0a@AM3PR48MB0130.041d.mgd.msft.net>
 <115943e8-eaf2-66f2-800f-bee51b5f9375@mperpetuo.com>
 <e97e0cc68f64487182e38b4707f5622e@AM3PR48MB0130.041d.mgd.msft.net>
From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <ab68d15d-f883-61c5-f946-a1a034cac0a4@mperpetuo.com>
Date: Mon, 12 Sep 2016 10:54:10 -0700
MIME-Version: 1.0
In-Reply-To: <e97e0cc68f64487182e38b4707f5622e@AM3PR48MB0130.041d.mgd.msft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [ARM64] Context saving problem with floating point
 registers?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 09/06/2016 09:02 AM, BREGARDIS Cedric wrote:

>
> Here are other options I could imagine:
> 1 - Contain the bug. Will I meet the floating point context saving
> problem if the xenomai application do not switch to the Linux
> Domain? Maybe the floating point problem only occur in certain
> conditions that I can ensure to not meet?

I haven't tested this, but I think you'll still run into the problem 
eventually. When your Xenomai process exits, it will switch back to Linux 
and the incorrect context will affect subsequent processes. Also, I'm not 
sure if the switch to Xenomai would even work correctly in the first place.

> 2 - Use the SoC in 32 bits mode (aarch32). Does the fpsimd switch
> mechanism works correctly on 32 bits ARM on xenomai for 4.1.x?

If you run an armv7 kernel on your board ala rpi3, you will be using the 
armv7 Xenomai port, which I believe is pretty stable. This could be the 
easiest way to go if you have access to such a kernel.

> 3 - Wait for a correction of xenomai. Is it expected to be available
> soon? It would be unfortunate to work on a complex workaround while
> someone is working on this problem and will release a fix soon.

I don't think anyone is working on this at the moment. You are always 
welcome to submit a patch :)

The proper fix would involve adjusting the context switch code on the 
Xenomai side to play nice with the kernel side. It needs to work correctly 
with the TIF_FOREIGN_FPSTATE thread flag, and the algorithm that uses it. I 
will probably be taking a look at this myself sometime in the future, but I 
can't really give you any sort of timeline at the moment.

Another possible suggestion is to try and port the 3.18 ipipe patch back to 
the 3.14 kernel. Likely more work than 2), but should be doable.

Regards,
Dmitriy


>
> Best regards,
> Cedric
>
>
> ________________________________
> CONFIDENTIALITY : This e-mail and any attachments are confidential and may be privileged. If you are not a named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose or store or copy the information in any medium.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>


