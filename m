References: <1537781213143.32741@rcilab.in>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <27836ceb-b13e-7993-14bc-66c04083fdee@siemens.com>
Date: Mon, 24 Sep 2018 15:12:33 +0200
MIME-Version: 1.0
In-Reply-To: <1537781213143.32741@rcilab.in>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT_QUEUE not defined in kernel space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kranthi Kumar Rentala <kranthi.kumar@rcilab.in>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 24.09.18 11:26, Kranthi Kumar Rentala wrote:
> hi,
> 
> 
> i am porting drivers from xenomai -2.6.5 to xenomai-3.0.5. I need to send data from driver(kernel space)  to application (user space).
> 
> In the old version i used RT_QUEUE for transferring data. I did not see any queues in Xenomai-3.0.5 version.
> 
> Can any one please help me out.
> 

See doc/asciidoc/MIGRATION.adoc: We reduced the in-kernel API. You should check 
if any of the RTDM-services for drivers help to model your case or otherwise 
describe the channel you are looking for in more details.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

