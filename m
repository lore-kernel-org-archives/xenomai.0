References: <1910322472.5076643.1539761140698.JavaMail.zimbra@wolfram.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a750f925-fd61-00d7-0f6d-715ce3d50cdf@xenomai.org>
Date: Wed, 17 Oct 2018 09:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <1910322472.5076643.1539761140698.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Similarities between UIO and RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 10/17/2018 09:25 AM, Per Oberg wrote:
> Hello all
> 
> I am looking at a piece of hardware that is supported in linux using a userspace library together with the UIO kernel module. The UIO kernel module is available in the standard linux kernel. 
> 
> Could someone make an educated guess whether it's feasible to port this userspace library to Xenomai and RDTM ? 
> 
> How similar are the UIO and RTDM interfaces?
> 

You may want to have a look at the UDD driver from the Xenomai
distribution, which is a RTDM-based version of UIO.

-- 
Philippe.

