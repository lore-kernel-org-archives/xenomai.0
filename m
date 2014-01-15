Message-ID: <52D68FF0.6040504@siemens.com>
Date: Wed, 15 Jan 2014 14:41:04 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <4F6C25B906613147991AA0B688C61D1F1D9F082C@SRVEXCHANGE.ona-electroerosion.com>
In-Reply-To: <4F6C25B906613147991AA0B688C61D1F1D9F082C@SRVEXCHANGE.ona-electroerosion.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Accessing an EtherCAT master from a Xenomai driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Asier Tamayo <asier.tamayo@onaedm.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-01-15 09:55, Asier Tamayo wrote:
> Hello all,
> 
> I'm using IgH EtherCAT master for Linux, from EtherLab. I have a problem with accessing the master from a RTDM driver.
> 
> I've already asked this question in the EtherLab list, but have received no response, so I'm posting it here in case someone has worked with EtherLab but is no more in the mailing list.
> 
> My problem is the following:
> 
> I can access the EtherCAT master from a Xenomai user task, but have found no way to do it from a RTDM driver. In my tests, I have tried to follow the functions from the Xenomai example, but I find some problems I can't see how to resolve.
> 
> For instance, the Xenomai example (user space application) calls ecrt_master_activate(), which eventually calls rtdm_mmap_to_user(): in the RTDM driver, rtdm_mmap_to_user() is called with a user_info value set to NULL, and it crashes. Also, some functions have to be called in non-RT context. For example, ecrt_master_slave_config(), which allocates memory by causing a page fault.
> 
> I hope this time I'll have better luck. Best regards,

The right address for your request remains the EtherLab Master project -
or you need to fix it yourself. Probably, their RTDM driver is not well
prepared for being used by other drivers and requires adaptions. Or
there are some details missing in the API documentation, e.g. that you
do not need to invoke that service which performs rtdm_mmap_to_user.
Moreover, from a quick look over it, EtherLab contains several
conceptual bugs /wrt RTDM API usage, so I would look carefully at the
whole thing.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

