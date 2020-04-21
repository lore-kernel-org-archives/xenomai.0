Subject: Re: FAILURE run_gdb:287: checking expression "primary_mode", expected
 "$", found "N"
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
 <230535ea0245408dbd941bc26c4f6df9@intel.com>
 <bbab7ccf-0f5e-617a-2d94-afc79f2d7efa@siemens.com>
 <CALLqZ8Qk-BEuYjYtRpqkTVT5N9iWJHpU=3n109jCMCy4Yd_8TA@mail.gmail.com>
 <20200201112301.5d3146d9@md1za8fc.ad001.siemens.net>
 <20200420221850.xjzzrpdfoherz6hm@altlinux.org>
 <20200421002728.wugbqtzibmbuqyzk@altlinux.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5c0e4c46-e58f-f256-3946-c63470be511a@siemens.com>
Date: Tue, 21 Apr 2020 12:00:35 +0200
MIME-Version: 1.0
In-Reply-To: <20200421002728.wugbqtzibmbuqyzk@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
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
To: Xenomai <xenomai@xenomai.org>

On 21.04.20 02:27, Vitaly Chikunov via Xenomai wrote:
> 2. There is additional problem with gdb test, though. If I have in my
> `.gdbinit' value of `prompt' redefined - gdb test fails to recognize the
> prompt.  I recommend adding `-nx' option to gdb arguments so that
> `.gdbinit' is not read by default.
> 
> gdb --help:
>    --nh               Do not read ~/.gdbinit.
>    --nx               Do not read any .gdbinit files in any directory.
> 
> I believe these changes will make xeno-test more robust.
> 

Good point! Should be added to the smokey gdb testcase where it starts 
gdb. Would you send a patch?

> 3. Also, note that `-k' switch is not worked.

There are several test cases in smokey, gdb included, that terminate the 
test process on errors. Probably, those need to be changed to return an 
error code from the test main function. Not trivial in all cases.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

