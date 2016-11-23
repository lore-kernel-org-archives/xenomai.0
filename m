References: <AE798E990C72C345B223A9C86007D6E8687FCD05D2@CNSHA01078.cn001.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c458c7f2-1b27-c87d-365b-115feec2493a@xenomai.org>
Date: Wed, 23 Nov 2016 10:19:24 +0100
MIME-Version: 1.0
In-Reply-To: <AE798E990C72C345B223A9C86007D6E8687FCD05D2@CNSHA01078.cn001.siemens.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "mian.huang@siemens.com" <mian.huang@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/23/2016 10:13 AM, mian.huang@siemens.com wrote:
> Hi:
> 
> One more question:
> 
> Right now I'm using the ls2085ardb for xenomai porting and its latest kernel
> version is 4.1.8,and soon will be upgraded to 4.1.30.
> 
> So is it possible to patch the linux  4.1.8 src for arm64 architecture right now?
> It seems that the xenomai-3.0.3 only provides the "ipipe-core-4.1.18-arm-8.patch" and
>  "ipipe-core-core-4.1.18-arm64-6.patch",which work correctly for 4.1.18 but
>  failed  for both 4.1.8 and 4.1.30.
> 
> I heard that the xenomai only provided preliminary support for arm64 arch,
> but how can I patch the linux kernel source for arm64 architecture since it doesn't
> provide the arm64 arch option.

arm64 is not in the stable branch yet, but in the -next one:
http://git.xenomai.org/xenomai-3.git/log/?h=next

-- 
Philippe.

