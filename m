References: <d3f6995a-1d45-d262-21a0-97a51253da91@alaxarxa.net>
 <e665e5ab-796f-8aac-997c-33b88079d27c@xenomai.org>
 <a30fcf3f-ad18-0210-ad51-6a0ab0b73872@alaxarxa.net>
 <bd2c4a53-33cf-b4aa-79c5-243fe1d5b660@xenomai.org>
 <275c60a3-db60-fdb7-7ffc-96988ca50913@alaxarxa.net>
 <a58f4cc0-0e42-c1d6-71e6-c18b00d1076d@xenomai.org>
 <52b92049-fcaa-8d48-8e89-516fc6f0ab21@alaxarxa.net>
 <6d2aee3e-2ddc-3008-f00e-a350030efcf3@xenomai.org>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <bc03b087-9547-64f3-ab80-f79845a997d1@alaxarxa.net>
Date: Fri, 24 Nov 2017 11:34:37 +0100
MIME-Version: 1.0
In-Reply-To: <6d2aee3e-2ddc-3008-f00e-a350030efcf3@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Testing 3.0.6 (Was Re: Cannot initialize TLSF memory
 manager)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi (again)

running cross-link I got that:

>> with my user
>>
>> ./cross-link
>> mem=0x7f0d630488e0, alloc_size=8192
>> Init memory pool returns 1808 bytes
>> Running after ...
>> sysregd:
>> create_directory_recursive("/var/run/xenomai/leopold.palomo/anon@19479"):
>> Permission denied

....


the permissions are:
$ ls -la /var/run/xenomai/
total 0
drwxr-xr-x  3 root root  60 nov 23 16:03 .
drwxr-xr-x 24 root root 860 nov 24 11:12 ..
drwxr-xr-x  2 root root  40 nov 24 11:12 root

so, IMHO this folder should belongs to xenomai group and permisions g+rw. Right?

Changing the permissions manually solved it. It's something about the packaging
or the library?


>> leopold.palomo@bmm3 ~/xenomai/xenomai-3.0.6/system/demo$ sudo ./cross-link
>> mem=0x7fc9e73f88e0, alloc_size=8192
>> Init memory pool returns 1808 bytes
>> Running after ...
>> mem=0x7f2e146318e0, alloc_size=8192
>> Init memory pool returns 1808 bytes
>> Running after ...
>> main : can't open /dev/rtdm/rtser0 (write), No such file or directory

> 
> Not being able to open rtser0 is yet another kind of problem: the uart
> driver is not up and running, so the devices were not created. crosslink
> definitely needs such driver.

Yes, I don't have rtser0 entry in /dev/rtdm/. Who does create it?

Also, /dev/cpu_dma_latency should not belongs to xenomai group?

Best regards,

Leopold

-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

