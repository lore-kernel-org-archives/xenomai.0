Message-ID: <54E5F030.6060403@xenomai.org>
Date: Thu, 19 Feb 2015 15:16:16 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANWkrRN54ohRTAuyfySuc_hqZWB=cA277imt8uAQhfR5bVr5ig@mail.gmail.com>
In-Reply-To: <CANWkrRN54ohRTAuyfySuc_hqZWB=cA277imt8uAQhfR5bVr5ig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Compiling issue Xenomai 3.0 rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>, xenomai@xenomai.org

On 02/19/2015 02:40 PM, Michael Smith wrote:
> Hi. I'm having trouble compiling the newest release (Xenomai 3.0-rc3).
> With the error
> 
> autotune.c: In function ‘main’:
> autotune.c:298:16: error: ignoring return value of ‘daemon’, declared with
> attribute warn_unused_result [-Werror=unused-result]
>           daemon(0, 0);
> 
> Is there an way to override the -Werror flags so it doesn't break on
> warnings without editing the make files?
> Or is the policy on Xenomai to always compile cleanly without warnings.

There is a strong policy to always compile without any warning. It
turned out that none of the libc headers I'm building against over 7 CPU
architectures sets the warn_unused_result attribute on the daemon()
routine yet.

-- 
Philippe.

