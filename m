Message-ID: <45ABBB19.3050500@domain.hid>
Date: Mon, 15 Jan 2007 18:34:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Search in the API-doc-trunk?
References: <200701151720.13175.nils.kemper@domain.hid>
In-Reply-To: <200701151720.13175.nils.kemper@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nils Kemper <nils.kemper@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Nils Kemper wrote:
> Hi,
> if I follow the links from the Xenomai-Wiki to the trunk-version of the 
> API-documentation (http://www.xenomai.org/index.php/API_documentation), the 
> search feature doesn't really work like in the versions before:
> e.g. if I search for "rt_heap", it doesn't return any results and for "rt_" 
> there are only 45 matched documents found vs. 179 in version 2.2 
> (http://www.xenomai.org/documentation/branches/v2.2.x/html/api/index.html).
> Is this planned and I have to use another search-"entry"?

No, this is a mistake, search.idx in the trunk seems to only index RTDM
 documentation. This reminds me that we should add a link to the
documentation of the 2.3.x branch.

-- 
                                                 Gilles Chanteperdrix

