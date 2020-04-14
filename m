Subject: Re: What are the differences bettween rtdm_open function and open
 function used to get the file handle of the rtdm driver?
References: <CAAvDm6a5m=-6hRAnGh_3hMeZ4ez1QuRNRoFa7Q5kv-4c+JQLAw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6ef22223-a0df-4e80-0165-8af870084ddf@siemens.com>
Date: Tue, 14 Apr 2020 11:00:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6a5m=-6hRAnGh_3hMeZ4ez1QuRNRoFa7Q5kv-4c+JQLAw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 14.04.20 10:55, 孙世龙 via Xenomai wrote:
> Hi，
>         The rtdm_open function is described as inter-driver interface.
>         What are the differences between rtdm_open function and open
> function used to get the file handle of the rtdm driver.
>         I have searched all the source code of xenomai-3.1.I found no usage
> of this function.

The usage of this function is rare, maybe even zero out there. The idea 
behind it is to allow driver stacking: One or more RTDM drivers provides 
lower-level interfaces, e.g. to get a UART device, another one uses that 
to provide a higher-level protocol on top that cannot or should not be 
implemented in user-space. However, the latter is often not an issue, so 
you find no users of this stacking pattern in-tree. If you don't see a 
case yet for yourself, ignore the API.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

