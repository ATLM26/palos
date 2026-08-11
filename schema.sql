-- ============================================================
--  PALOS · esquema de base de datos
--  Pegá TODO este archivo en Supabase → SQL Editor → Run.
--  Se puede correr más de una vez sin romper nada.
-- ============================================================

-- ---------- PARTIDOS ----------
create table if not exists public.partidos (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  fecha       date,
  rival       text,
  torneo      text,
  condicion   text,                       -- 'local' | 'visitante' | null
  notas       text,
  created_at  timestamptz not null default now()
);

-- ---------- PATADAS ----------
create table if not exists public.patadas (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  partido_id  uuid references public.partidos(id) on delete cascade,
  x           real not null,              -- coordenadas en el sistema de la cancha dibujada
  y           real not null,
  entro       boolean not null,
  tipo        text not null default 'penal',   -- 'penal' | 'conversion' | 'drop'
  distancia   real,                            -- metros a los palos (calculado en el cliente)
  created_at  timestamptz not null default now()
);

create index if not exists patadas_user_idx    on public.patadas(user_id);
create index if not exists patadas_partido_idx on public.patadas(partido_id);
create index if not exists partidos_user_idx   on public.partidos(user_id);

-- ---------- SEGURIDAD (Row Level Security) ----------
-- Sin esto, cualquiera con la clave pública leería los datos de todos.
alter table public.partidos enable row level security;
alter table public.patadas  enable row level security;

drop policy if exists "partidos propios" on public.partidos;
create policy "partidos propios" on public.partidos
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "patadas propias" on public.patadas;
create policy "patadas propias" on public.patadas
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
