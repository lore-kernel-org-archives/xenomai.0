Subject: Re: arm64 support
References: <DM5PR15MB11635BC3912646333637C66FF0430@DM5PR15MB1163.namprd15.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9c64de1d-dacd-3d1e-674e-0e5b93d55ab3@siemens.com>
Date: Mon, 2 Dec 2019 12:46:48 +0100
MIME-Version: 1.0
In-Reply-To: <DM5PR15MB11635BC3912646333637C66FF0430@DM5PR15MB1163.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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
To: smpd support <symphonic.mpd@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02.12.19 12:41, smpd support via Xenomai wrote:
> Hello.
> 
> I am developing in the following environment.
> * Raspberry Pi 3b
> * Linux 4.14. 52 (arm)
> * Xenomai 3.0. 7
> 
> I want to build a 64 bit (arm 64) kernel for use with a Raspberry Pi 3 b (or Raspberry Pi 4b).
> 
> The Raspberry Pi 3b (arm 64) was mentioned on the wiki as a Xenomai evaluation board.
> Could you recommend a combination of versions?
> * Linux kernel
> * .config
> * ipipe patch
> * Xenomai
> 

Try 3.1-rc3 (or the master branch directly). 4.19-based I-pipe is
strongly recommended. See also [1] for a working arm64 setup, on a hikey
though.

Jan

[1] https://gitlab.denx.de/Xenomai/xenomai-images

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

