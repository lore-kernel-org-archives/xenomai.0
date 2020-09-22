Subject: Re: RTDM read/write callback with parameters
References: <ab28815f-96f0-606f-bb0d-c812678ef97b@aim-online.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ec089a4c-25df-2d75-c996-1b96a200398b@siemens.com>
Date: Tue, 22 Sep 2020 17:18:18 +0200
MIME-Version: 1.0
In-Reply-To: <ab28815f-96f0-606f-bb0d-c812678ef97b@aim-online.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Martin Haag <haag@aim-online.com>, xenomai@xenomai.org

On 21.09.20 15:49, Martin Haag via Xenomai wrote:
> Dear list members,
> 
> I am porting a Linux PCI character device driver to Xenomai 2.6.5.
> 
> I can not find a RTDM expression for the "parameters" argument of the
> struct file_operations read callback.
> 
> struct file_operations:
> ssize_t aim_read(struct file* file, char __user *parameters, size_t
> parameterSize, loff_t* offset);
> 
> struct rtdm_operations:
> ssize_t aim_rtdm_read(struct rtdm_dev_context *context, rtdm_user_info_t
> *user_info, void *buf, size_t nbyte)
> 

buf would map to parameter in the kernel interface, and there is no 
equivalent of offset.

HTH,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

