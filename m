Message-ID: <49E492A7.3090301@domain.hid>
Date: Tue, 14 Apr 2009 15:41:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9872A1CE-C4C3-4E7B-B6A2-AF559B54792D@xenomai.org>
In-Reply-To: <9872A1CE-C4C3-4E7B-B6A2-AF559B54792D@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Documentation][Patch] Framework upgrade and a
 few	fixes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Piquesel <piquesel@domain.hid>
Cc: xenomai@xenomai.org

Piquesel wrote:
> Hi,
> 
> here is a patch on the documentation, which is the first one of a  
> longer series. More to come in the next few weeks:
> - migration of remaining technical articles: Native API Tour (half  
> done), RTDM (to be discussed...);
> - getting started guide: a short guide trying to answer basic  
> questions of newcomers and to point to proper ressources. The  
> information is generally there, but way too much scattered IMO: README  
> files, website, external websites, older posts on mailing-list archives;
> - improvement of pdf generation;
> - probably upgrade of maintenance scripts due to svn -> git migration;
> - website update in order to link properly to the doc.
> 
> This first patch fixes a few bugs here and there in the XML and CSS  
> files and also integrate pictures reworked with Inkscape. SVG original  
> files have been committed in order to be easily reused or fixed by  
> others if needed.
> 
> config/docbook.m4 has been updated in order to add a --with-fop  
> parameter in order to easily use the latest version of documentation  
> tools (fop in this case). In fact, fop-0.94 installed on most current  
> Linux host distribution has some nasty bugs and can't deal for  
> instance with png pictures properly. This patch may not be absolutely  
> necessary since we are probably two in the world to use that but oh  
> well :) Please check the added AC_CHECK_PROG, I'm really not fluent  
> with autoconf!
> 
> Please, let me know if the patch is correct. I'm just starting using  
> git and I'm not very familiar with all the functionality yet. It seems  
> binary files are well handled but it's the first time I try.

I am OK with the patches, I will start merging them in my tree. However,
 please send me the whole patch set when you are finished. Another
remark: your commit message can give more details. The first line is
used as a short log, then you should skip a line, and the rest is used
as a detailed commit log. Now that we have abandoned the ChangeLog (I am
not complainling), the commit messages are all that we have.

-- 
                                                 Gilles.

