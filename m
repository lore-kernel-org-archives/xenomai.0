Message-ID: <8875f1c3-14c8-d275-b531-1d70a09aefc5@siemens.com>
Date: Tue, 8 Mar 2022 08:11:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] libtraceevent: Add xenomai_schedparams plugin for
 libtraceevent
Content-Language: en-US
References: <20220304052140.17196-1-hongzhan.chen@intel.com>
 <20220304052140.17196-3-hongzhan.chen@intel.com>
 <e48eda27-9d11-7caf-48d3-d40b473619fa@siemens.com>
 <MN2PR11MB4285F7C0F6FDB29141B6C78AF2099@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285F7C0F6FDB29141B6C78AF2099@MN2PR11MB4285.namprd11.prod.outlook.com>
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

On 08.03.22 01:06, Chen, Hongzhan wrote:
>>> +
>>> +  Please copy built libplugin_xenomai_schedparams.so to
>>> +  /usr/local/lib/traceevent/plugins/ or
>>> +  /usr/local/lib64/traceevent/plugins/ depending on your system.
>>> +  While libtracevent and its plugins is installed correctly, the plugins
>>> +  would be loaded automatically by other module such as libtracecmd after
>>> +  corresponding tracing tool run such as kernelshark or tracecmd.
>>
>> I should use the changes below to switch to pkg-config - that permits
>> control over the installation path as well.
>>
>> In addition, Xenomai should install the plugins properly, into the same 
>> folders as kernelshark and libtraceevent use.
> 
> Is that possible that it install just the plugin-ins when we execute make install after build but do not install  Xenomai itself? Because Xenomai may install
> cross platform not local machine and they have different targets.  Users may just want to install plugins into its host but do not want to touch its target Xenomai.  

Multiple options:

 - make -C tracing/... install
 - DESTDIR=... make install; cp DESTDIR/usr/lib/kernelshark/... target-folder
 - run packaging; apt install xenomai-kernelshark-plugin  

BTW, installation already works, just not into the right folders.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

