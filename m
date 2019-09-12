Subject: Re: [PATCH] debian/rules: Add debug symbols
References: <20190911160519.25505-1-Quirin.Gylstorff@siemens.com>
 <31511e19-0a48-6f40-0474-4358336bcb1a@xenomai.org>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <9c8c8a11-4377-3a6c-7d52-b74a0f2d86b5@siemens.com>
Date: Thu, 12 Sep 2019 10:38:33 +0200
MIME-Version: 1.0
In-Reply-To: <31511e19-0a48-6f40-0474-4358336bcb1a@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org



On 9/12/19 10:29 AM, Philippe Gerum wrote:
> On 9/11/19 6:05 PM, Q. Gylstorff via Xenomai wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Configure debian build with debugging symbols to allow debugging.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   debian/rules | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/debian/rules b/debian/rules
>> index 08562c7ab..ef209712f 100755
>> --- a/debian/rules
>> +++ b/debian/rules
>> @@ -17,7 +17,8 @@ CONFIG_OPTS = --prefix=/usr \
>>               --includedir=/usr/include/xenomai \
>>               --mandir=/usr/share/man \
>>               --with-testdir=/usr/lib/xenomai/testsuite \
>> -            --enable-smp
>> +            --enable-smp \
>> +            --enable-debug
>>   
>>   ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
>>   	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
>>
> 
> This also enables some internal consistency checks by default which come
> with a runtime cost especially for anything on top of libcopperplate,
> although not as noticeable as with --enable-debug=full. If you only want
> debug symbols to be generated, --enable-debug=symbols is recommended.
>

Thanks for the information. I will add to the configuration.

Quirin


