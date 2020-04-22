Subject: Re: Error on running xeno-test
References: <LEXPR01MB1215811EAA36B9C17EFE718C8FD20@LEXPR01MB1215.DEUPRD01.PROD.OUTLOOK.DE>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4e46a42b-e8f0-f96b-8589-f05f6c76512b@siemens.com>
Date: Wed, 22 Apr 2020 11:45:54 +0200
MIME-Version: 1.0
In-Reply-To: <LEXPR01MB1215811EAA36B9C17EFE718C8FD20@LEXPR01MB1215.DEUPRD01.PROD.OUTLOOK.DE>
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
To: Jona Ostermann <Jona.Ostermann@janztec.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 22.04.20 11:26, Jona Ostermann via Xenomai wrote:
> Hello,
> 
> I am currenty testing my Xenomai Cobalt v3.1 installation on Debian 9 with kernel version 4.9.146.
> 
> When running xeno-test, I get the following output:
> 
> ++ echo 0
> ++ testdir=/usr/xenomai/bin
> ++ /usr/xenomai/bin/smokey --run random_alloc_rounds=64 pattern_check_rounds=64
> arith OK
> bufp OK
> cpu_affinity skipped (no kernel support)
> fpu_stress OK
> FAILURE handle_sigchld:78: gdb execution returned 3 instead of 0 - No such proce                                      ss
> child 880 returned: exited with status 1
> 
> 
> what could cause this error?
> 

Do you have gdb installed on the target? If that should be the error, we 
likely need to improve on reporting it.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

