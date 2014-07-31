Message-ID: <53DA13F2.8070000@xenomai.org>
Date: Thu, 31 Jul 2014 12:01:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1406798751.57963.YahooMailNeo@web172706.mail.ir2.yahoo.com>
In-Reply-To: <1406798751.57963.YahooMailNeo@web172706.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with x86 and Ubuntu 14.04
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/31/2014 11:25 AM, Franz Engel wrote:
> 
> 
> Hi,
>  
> I try to install Xenomai on my new Ubuntu 14.04 x86 64bit system. The standard kernel is 3.13. So I used the 3.14 vanilla kernel, ipipe-3.14 and xenomai 2.6.3. But I get an compilation error:
> "'struct task_struct' has no member named 'fpu_counter'
> next->fpu_counter=0"

You need to pull from our maintenance tree for building over kernel >
3.8, git.xenomai.org/xenomai-2.6. This will be released as 2.6.4 within
a few weeks.

> Then I tried to use the kernel 3.8. I could install the pached kernel but I can't login into Ubuntu after restart.

This description does not give the reader any hint about what happened,
beside the fact that you are not able to access your account. A more
descriptive information may help people to help you.

> Does somebody has experiences with Xenomai on Ubuntu 14.04? Or is it needfull to change the Ubuntu version?
>  

Most likely not. Please check xenomai.org for documentation and tips
regarding the installation on x86. At least initially, you may want to
reuse the kernel .config shipped with your distro for building the
patched kernel.

> regards,
>      Franz 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

