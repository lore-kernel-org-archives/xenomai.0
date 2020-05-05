Subject: Re: how to customize kernel command line in a kas-docker project?
References: <e0fdd47a4fb34d0c9ffa74b55d244467@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4ad707ae-73b3-c66f-9880-946237fbf71e@siemens.com>
Date: Tue, 5 May 2020 21:25:51 +0200
MIME-Version: 1.0
In-Reply-To: <e0fdd47a4fb34d0c9ffa74b55d244467@intel.com>
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
To: "Meng, Fino" <fino.meng@intel.com>, xenomai <xenomai@xenomai.org>

On 05.05.20 20:25, Meng, Fino via Xenomai wrote:
> hi team,
> 
> These days I am working on https://gitlab.denx.de/Xenomai/xenomai-images which use kas-docker,
> I need to customize kernel command line for my build.  The 2 ways I found now:
> 
> 1) directly modify wic/x86-64-efi.wks, update following line:
> bootloader --ptable gpt --timeout=5 --append "rw rootwait console=ttyS0,115200"
> 
> 2) add config files for a new board: board-xxx.yml, conf/machine/xxx.conf, wic/xxx.wks;
> then add my own kernel cmdline in xxx.wks;
> 
> is it possible to achieve this task in a non-intrusive way, without adding new board?
> add new cmdline in a new file and override the original,
> same working mechanism as  "PREFERRED_VERSION_linux-xenomai" ?
> 

Many options are available, e.g.

  - overwrite WKS_FILE to point to your own version, even only for the
    target in question (WKS_FILE_x86-64-efi = "...")

  - give your own layer a higher prio and provide an own version of the
    wks file under the same name

  - introduce a template for the wks file (x86-64-efi.wks.in), add a
    variable for the command line param and maintain that var also in
    your layer

  - ...

It's basically what bitbake allows you to do, plus in this case some 
specifics of the wic integration into Isar (templating - though I think 
that OE provides the same).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

