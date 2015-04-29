Date: Wed, 29 Apr 2015 06:30:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150429043026.GI1993@hermes.click-hack.org>
References: <CADvZd9azLVdxYd8gy4BwT8Fh1LixV_=vbZoAAZegJ+rAut8mng@mail.gmail.com>
 <20150428160255.GD1993@hermes.click-hack.org>
 <6EE509AA-B0D3-40DC-9DEA-63E1DCDB39A6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6EE509AA-B0D3-40DC-9DEA-63E1DCDB39A6@gmail.com>
Subject: Re: [Xenomai] RT-CAN driver for C_CAN,D_CAN cores ready
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Apr 28, 2015 at 10:19:26PM +0200, Michael Haberler wrote:
> Gille -
> 
> > Am 28.04.2015 um 18:02 schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > 
> > On Tue, Apr 28, 2015 at 05:47:40PM +0200, Michael Haberler wrote:
> >> as requested:
> > 
> > This is a mess, really, you add files to remove them later.
> 
> Steve started with the vanilla c_can driver, copied and renamed the files. But the code still shares a lot with the original.
> 
> I do think history is important - when searching for a bug this driver introduced, or backporting a fix to the vanilla driver.
> 
> This is why you see what you see. I think it is more relevant than aesthetics.
> 
> If you prefer to have a history-free squash, that is fine too - I pity the fellow trying to nail a bug though. Please advise.

The diff which renames the files contains absolutely no valuable
information:

- if the files were just renamed, then it contains a lot of lines
for just a few rename commands, and you can make this patch
disappear in the git history, simply starting with files with the
right names, and not loose any relevant information (I do not see
what the information that the file was named c_can.c then renamed
rtc_can.c brings to someone looking for a bug); 

- if the files were both renamed and modified by this commit, the
information about what was modified is lost, because the diff
contains a file removal and a file addition, not the crucial
difference between the two files.

> 
> > 
> > A patch should be against Xenomai sources, and for adding a driver
> > it should only add file or modify existing files.
> > 
> > Second point, the indentation, Xenomai follows the linux kernel
> > rules where the indentation "unit" is a tab characters which should
> > be displayed as 8 spaces by diff. Here your indentation seems to be
> > one space (maybe your mailer did that ?).
> 
> To exclude that option is why I attached the file. For reference, umutilated originals are here: https://github.com/mhaberler/xenomai-2.6/commits/bbcan

The problem is that a patch review usually includes quotes of the
original patches. Writing a reply to your mail by quoting these
patches from an http server or an attachment is way more painful
than simply replying to a mail which contains the patches, inline,
because then the mail client quotes the whole patch and you simply
have to keep what you do not like and write comments below. Note
that I am not writing anything new or original here, this topic is
well covered in the kernel documentation, including ways to
configure various mail clients so that they quote the patches and do
not mangle them. A simple way is to use git send-email.

> 
> I didnt write this - I am just moderating the process, but I can reformat as requested.

Yes, please remove the rename commit, and post the patches with git
send-email. I am sorry to insist, but this is a big patch.

-- 
					    Gilles.

