Subject: Re: PCI UDD Questions
References: <MQAHYHsv-KztU7kmKMe1zEyj1YMioxUAHWXO8cjixmGgcY0FuEcPL73Bj0NZxsH9mlyrmGJ1rhAWMr7ii-ErIRz9qSqRXvnyBibYa3AZSAE=@codecraftsmen.org>
 <ecf0bf08-f93e-3c67-a71e-fb25d683930c@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <827166fb-a317-e42c-dda3-dd83fcfdbbf5@siemens.com>
Date: Wed, 6 Mar 2019 18:38:47 +0100
MIME-Version: 1.0
In-Reply-To: <ecf0bf08-f93e-3c67-a71e-fb25d683930c@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, Jeff Webb <w1@codecraftsmen.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06.03.19 12:24, Philippe Gerum via Xenomai wrote:
> On 3/2/19 1:25 PM, Jeff Webb via Xenomai wrote:
>> I could also avoid using the PCI command register entirely and just write to a device-specific mask bit in my peripheral, but I would rather implement a generic solution if there is not a performance penalty for using the PCI command register.
>>
> 
> I don't think that using the PCI layer would be cheaper than tweaking
> some bit in your device. The former involves a serialization on
> pci_lock, then a read-update-write sequence to send the
> masking/unmasking command to the bus layer. Sending the acknowledge to
> the device in order to stop it from interrupting is the usual way for rt
> sources.

Plus PCI config accesses (which are needed for generic INTx masking) are 
generally more expensive than device register accesses. So don't use them for 
masking, whenever possible.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

