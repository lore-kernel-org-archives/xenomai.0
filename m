Subject: Re: undefined symbol in tests
References: <CAPnNZ0UJEFhQXnmkH=RyBWVuXWiymw-S3jCcH+U5B_1VESALJA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cd4f3b32-d2bf-a96d-527a-5f7f3403e4d2@siemens.com>
Date: Fri, 14 Feb 2020 10:53:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAPnNZ0UJEFhQXnmkH=RyBWVuXWiymw-S3jCcH+U5B_1VESALJA@mail.gmail.com>
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
To: Antoine Hoarau <antoine@flr.io>, Xenomai <xenomai@xenomai.org>

On 14.02.20 10:48, Antoine Hoarau via Xenomai wrote:
> If I run xeno tests I get :
> symbol lookup error: /usr/lib/libalchemy.so.0: undefined symbol: __real_free
> /usr/lib/xenomai/testsuite/smokey: test dlopen failed: Unknown error -127
> child 1458 returned: exited with status 1
> 
> Tests on 3.1 release.
> 

As this ran through our testlab here, there must be some local deviation 
in your build. Can you provide more details on how and for what you built?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

