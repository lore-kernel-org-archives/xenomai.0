Subject: Re: I wonder that wheather the the rtdm interface could be called in
 user space?
References: <CAAvDm6YPY-3BMx1RJOyZA3hcTb6ZUZovwmuGk-SiwK5usQP3GQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d9368318-2d85-d7eb-41f1-132afde63a9c@siemens.com>
Date: Thu, 16 Apr 2020 10:52:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6YPY-3BMx1RJOyZA3hcTb6ZUZovwmuGk-SiwK5usQP3GQ@mail.gmail.com>
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

On 16.04.20 10:13, 孙世龙 via Xenomai wrote:
> Hi,
>        I wonder that whether the the rtdm interface could be called in user
> space?I think it's impossible to call rtdm interface in main function.Am i
> right?
> 

Check our UDD for writing userspace drivers. The RTDM driver API itself 
is not available in userspace.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

