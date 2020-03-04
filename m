Subject: Re: GPIO interrupt not working on Zynq7000
References: <7231-5e5fdf80-11-3b6a0580@56070941>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f15068ac-b798-ebb0-beca-05d6e36e0c1f@siemens.com>
Date: Wed, 4 Mar 2020 18:13:07 +0100
MIME-Version: 1.0
In-Reply-To: <7231-5e5fdf80-11-3b6a0580@56070941>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 04.03.20 18:04, François Legal wrote:
> So to terminate on that ipipe topic, I checked the legacy ipipe 4.4.y / 4.4.y-cip branches, and none fo them seem to handle the zynq-gpio correctly. It looks like this has been fixed in 4.9.y branch.
> 
> Shall I submit a patch on this ?

That would be perfect. I already cherry-picked a few ARM patches from 
newer releases that Philippe pointed me to. If those apply, just list 
the commit shas. If not, please send the adjusted ones as backport. I 
would recommend to also check ipipe-4.19 for potential further fixes.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

