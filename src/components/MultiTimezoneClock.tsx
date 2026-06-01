'use client';

import React, { useState, useEffect } from 'react';
import { Clock, Globe } from 'lucide-react';

interface TimeZone {
  name: string;
  label: string;
  offset: string;
  city: string;
  flag: string;
}

const TIMEZONES: TimeZone[] = [
  {
    name: 'Asia/Jakarta',
    label: 'WIB (Jakarta)',
    offset: 'UTC+7',
    city: 'Indonesia - Waktu Indonesia Barat',
    flag: '🇮🇩',
  },
  {
    name: 'Asia/Jakarta',
    label: 'WITA (Makassar)',
    offset: 'UTC+8',
    city: 'Indonesia - Waktu Indonesia Tengah',
    flag: '🇮🇩',
  },
  {
    name: 'Asia/Jakarta',
    label: 'WIT (Jayapura)',
    offset: 'UTC+9',
    city: 'Indonesia - Waktu Indonesia Timur',
    flag: '🇮🇩',
  },
  {
    name: 'Asia/Tokyo',
    label: 'Tokyo',
    offset: 'UTC+9',
    city: 'Japan',
    flag: '🇯🇵',
  },
  {
    name: 'Asia/Singapore',
    label: 'Singapore',
    offset: 'UTC+8',
    city: 'Singapore',
    flag: '🇸🇬',
  },
  {
    name: 'Asia/Bangkok',
    label: 'Bangkok',
    offset: 'UTC+7',
    city: 'Thailand',
    flag: '🇹🇭',
  },
  {
    name: 'America/New_York',
    label: 'New York',
    offset: 'UTC-5',
    city: 'USA',
    flag: '🇺🇸',
  },
  {
    name: 'Europe/London',
    label: 'London',
    offset: 'UTC+0',
    city: 'UK',
    flag: '🇬🇧',
  },
];

export default function MultiTimezoneClock() {
  const [times, setTimes] = useState<{ [key: string]: string }>({});
  const [dates, setDates] = useState<{ [key: string]: string }>({});

  useEffect(() => {
    const updateTimes = () => {
      const newTimes: { [key: string]: string } = {};
      const newDates: { [key: string]: string } = {};

      TIMEZONES.forEach((tz) => {
        const formatter = new Intl.DateTimeFormat('id-ID', {
          timeZone: tz.name,
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          hour12: false,
        });

        const dateFormatter = new Intl.DateTimeFormat('id-ID', {
          timeZone: tz.name,
          weekday: 'short',
          month: 'short',
          day: 'numeric',
        });

        newTimes[tz.name] = formatter.format(new Date());
        newDates[tz.name] = dateFormatter.format(new Date());
      });

      setTimes(newTimes);
      setDates(newDates);
    };

    updateTimes();
    const interval = setInterval(updateTimes, 1000);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 p-8">
      {/* Header */}
      <div className="max-w-7xl mx-auto mb-12">
        <div className="flex items-center gap-3 mb-2">
          <Clock className="w-8 h-8 text-blue-400" />
          <h1 className="text-4xl font-bold text-white">Jam Dunia</h1>
        </div>
        <p className="text-slate-400">Pemantauan waktu real-time di seluruh zona waktu global</p>
      </div>

      {/* Main Clock Grid */}
      <div className="max-w-7xl mx-auto">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {TIMEZONES.map((tz, index) => (
            <div
              key={index}
              className="relative group bg-gradient-to-br from-slate-700 to-slate-800 rounded-2xl p-6 shadow-xl hover:shadow-2xl transition-all duration-300 border border-slate-600 hover:border-blue-500"
            >
              {/* Glow Effect */}
              <div className="absolute inset-0 rounded-2xl bg-gradient-to-r from-blue-500/0 via-blue-500/0 to-cyan-500/0 group-hover:from-blue-500/10 group-hover:via-blue-500/10 group-hover:to-cyan-500/10 transition-all duration-300" />

              {/* Content */}
              <div className="relative z-10">
                {/* Header */}
                <div className="flex items-center justify-between mb-4">
                  <div className="flex items-center gap-2">
                    <span className="text-3xl">{tz.flag}</span>
                    <div>
                      <h3 className="text-lg font-bold text-white">{tz.label}</h3>
                      <p className="text-xs text-slate-400">{tz.city}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-xs font-mono text-blue-400">{tz.offset}</p>
                  </div>
                </div>

                {/* Digital Time Display */}
                <div className="bg-slate-900/50 rounded-lg p-4 mb-3 border border-slate-600">
                  <div className="text-center">
                    <div className="text-4xl font-mono font-bold text-cyan-400 tracking-wider mb-2">
                      {times[tz.name] || '00:00:00'}
                    </div>
                    <div className="text-sm text-slate-400 font-mono">
                      {dates[tz.name] || 'Loading...'}
                    </div>
                  </div>
                </div>

                {/* Activity Indicator */}
                <div className="flex items-center gap-2 text-xs text-slate-400">
                  <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                  <span>Live</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Footer Stats */}
      <div className="max-w-7xl mx-auto mt-12 p-6 bg-slate-800/50 rounded-xl border border-slate-700">
        <div className="flex items-center gap-2 mb-4">
          <Globe className="w-5 h-5 text-blue-400" />
          <h3 className="font-semibold text-white">Cakupan Zona Waktu</h3>
        </div>
        <p className="text-slate-400 text-sm">
          Memantau {TIMEZONES.length} zona waktu termasuk 3 zona waktu Indonesia (WIB, WITA, WIT) • Update setiap detik • Referensi UTC
        </p>
      </div>
    </div>
  );
}
