Subject: Re: [PATCH 1/1] gitlab-ci: add cache to decrease build times
References: <20200930105146.19902-1-Quirin.Gylstorff@siemens.com>
 <8108a4a6-674b-6813-4342-e81b30ffbb51@siemens.com>
 <2fa58248-e1a0-1a23-3147-a49e1a5b0a00@siemens.com>
 <94100773-8d7e-6467-38b6-1ece06290139@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ae4827fe-5cb1-df3c-21bc-64fae2ff025b@siemens.com>
Date: Tue, 13 Oct 2020 15:03:28 +0200
MIME-Version: 1.0
In-Reply-To: <94100773-8d7e-6467-38b6-1ece06290139@siemens.com>
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
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, xenomai@xenomai.org

On 13.10.20 11:35, Gylstorff Quirin wrote:
> 
> 
> On 10/12/20 12:36 PM, Jan Kiszka wrote:
>> On 07.10.20 10:10, Gylstorff Quirin wrote:
>>> Hi,
>>>
>>> Here is some data to the caching.
>>>
>>> during my test it reduced the build times from around 45min to around
>>> 25min.
>>
>> In travis, a warm rebuild was ~10 min. in the endGood to know. I will
>> look into the runner config.
> 
>>
>>> The size of the cache is for each build is around 500k.
>>
>> 500K? It used to be 200-300 MB in travis. Sounds a bit inconsistent.
> 
> Here is a log from ccache
> 
> https://gitlab.com/Quirin.Gy/xenomai/-/jobs/765078542.
> 
> Config change due to the switch to Debian.

But 500K really means we are not caching. Well, we are caching the
userspace build but not the more interesting kernel build.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

