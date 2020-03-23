Subject: Re: [xenomai-images PATCH 0/2] Add support for x86(32bit)
References: <20200214083819.31451-1-Quirin.Gylstorff@siemens.com>
 <44e9c257-f95b-9d39-8b0c-b81a6e91bae2@siemens.com>
 <278881260.559316.1584996188827@mail.yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a1c16d83-8230-693b-a3c4-d0c524331a92@siemens.com>
Date: Mon, 23 Mar 2020 21:49:16 +0100
MIME-Version: 1.0
In-Reply-To: <278881260.559316.1584996188827@mail.yahoo.com>
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
To: Alec Ari <neotheuser@ymail.com>, Xenomai <xenomai@xenomai.org>

On 23.03.20 21:43, Alec Ari wrote:
> Don't you need to modify entry_32.S for IPIPE?
> 

Subject might have been misleading: It only adds support to the image 
generator to build 32-bit userland. The kernel remains 64-bit. This 
allows us to model a product scenario on top - and to stress the compat 
code path in the test lab this way.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

