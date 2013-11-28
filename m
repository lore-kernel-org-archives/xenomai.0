Message-ID: <52973D47.9090004@xenomai.org>
Date: Thu, 28 Nov 2013 13:55:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <529701A6.5010100@geral.com> <52973C5A.8030105@xenomai.org>
In-Reply-To: <52973C5A.8030105@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] rtcan_flexcan: fix devtype_data initialization
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexandre COFFIGNAL <acoffignal@geral.com>
Cc: xenomai@xenomai.org

On 11/28/2013 01:51 PM, Gilles Chanteperdrix wrote:
> On 11/28/2013 09:41 AM, Alexandre COFFIGNAL wrote:
>> |fix devtype_data initialization when using CONFIG_OF and dtb file
>>
>> Signed-off-by: Alexandre COFFIGNAL <acoffignal@geral.com>
>
> Patch does not apply.
>
>>
>> |---
>>     ksrc/drivers/can/rtcan_flexcan.c |    6 ++++--
>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/ksrc/drivers/can/rtcan_flexcan.c b/ksrc/drivers/can/rtcan_flexcan.c
>> index e97cd92..8f0e8d1 100644
>> --- a/ksrc/drivers/can/rtcan_flexcan.c
>> +++ b/ksrc/drivers/can/rtcan_flexcan.c
>> @@ -1055,8 +1055,10 @@ static int flexcan_probe(struct platform_device *pdev)
>>     		devtype_data = (struct flexcan_devtype_data *)
>>     			pdev->id_entry->driver_data;
>
> I guess due to the carriage return introduced by your MUA here ^. The
> simplest solution to send correctly formatted mails is to use git
> format-patch and git send-email.
>

No, the carriage return is here in the original sources. So, I do not 
know why your patch does not apply, but still, if you use git to 
generate and send the patch, it should work.

-- 
					    Gilles.

