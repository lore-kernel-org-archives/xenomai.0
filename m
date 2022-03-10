Message-ID: <5a4d679a-0451-371b-05fd-d90f14ddb66a@siemens.com>
Date: Thu, 10 Mar 2022 08:17:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] KernelShark: Add xenomai_cobalt_switch_events
 plugin for KernelShark
Content-Language: en-US
References: <20220309023020.4883-1-hongzhan.chen@intel.com>
 <20220309023020.4883-2-hongzhan.chen@intel.com>
 <faacd493-a3ab-bb9b-ddaf-04760c89aeaf@siemens.com>
 <MN2PR11MB42851D37305322B24D5BE5A8F20A9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB42851D37305322B24D5BE5A8F20A9@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>

On 10.03.22 00:48, Chen, Hongzhan wrote:
> ...
>>> +libplugin_xenomai_cobalt_switch_events_la_CPPFLAGS  =	\
>>> +	$(KS_INCLUDS)
>>> +
>>> +install-libLTLIBRARIES: $(lib_LTLIBRARIES)
>>> +	echo "$(LIBTOOL) $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=install \
>>> +		$(INSTALL_DATA) $(lib_LTLIBRARIES)  '$(KS_INSTALLDIR)/kernelshark/plugins/'";	\
>>> +	$(LIBTOOL) $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=install \
>>> +		$(INSTALL_DATA) $(lib_LTLIBRARIES)  "$(KS_INSTALLDIR)/kernelshark/plugins/"
>>> +
>> Why that echo? automake supports V=1 for verbose mode IIRC.
> 
> I found the other Makefile created by autmake like lib/cobalt/Makefile would automatically insert such echo line. But in our case, it just keep original  content of install-libLTLIBRARIES: $(lib_LTLIBRARIES) of kernelshark Makefile.am. So I think we may refer to it to insert such echo line aligning with its design as far as I can.
> 

I don't see any value in such an echo. So please align with normal
automake patterns like Xenomai uses.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

